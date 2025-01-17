/**********************************************************************
 *
 * PostGIS - Spatial Types for PostgreSQL
 * http://postgis.net
 *
 * PostGIS is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * PostGIS is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with PostGIS.  If not, see <http://www.gnu.org/licenses/>.
 *
 **********************************************************************
 *
 * Copyright (C) 2011  OpenGeo.org
 * Modifications Copyright (c) 2017 - Present Pivotal Software, Inc. All Rights Reserved.
 *
 **********************************************************************/


#include "postgres.h"
#include "fmgr.h"
#include "executor/executor.h"
#include "utils/elog.h"
#include "utils/guc.h"
#include "libpq/pqsignal.h"

#include "../postgis_config.h"

#include "lwgeom_log.h"
#include "lwgeom_pg.h"
#include "geos_c.h"

#ifdef HAVE_LIBPROTOBUF
#include "lwgeom_wagyu.h"
#endif

/*
 * This is required for builds against pgsql
 */
PG_MODULE_MAGIC;

static pqsigfunc coreIntHandler = 0;
static void handleInterrupt(int sig);

#ifdef WIN32
static void interruptCallback() {
  if (UNBLOCKED_SIGNAL_QUEUE())
    pgwin32_dispatch_queued_signals();
}
#endif

static ExecutorStart_hook_type onExecutorStartPrev = NULL;
static void onExecutorStart(QueryDesc *queryDesc, int eflags);

/*
 * Module load callback
 */
void _PG_init(void);
void
_PG_init(void)
{
  coreIntHandler = pqsignal(SIGINT, handleInterrupt);

#ifdef WIN32
  GEOS_interruptRegisterCallback(interruptCallback);
  lwgeom_register_interrupt_callback(interruptCallback);
#endif

  /* install PostgreSQL handlers */
  pg_install_lwgeom_handlers();

  /* setup hooks */
  onExecutorStartPrev = ExecutorStart_hook;
  ExecutorStart_hook = onExecutorStart;
}

/*
 * Module unload callback
 */
void _PG_fini(void);
void
_PG_fini(void)
{
  elog(NOTICE, "Goodbye from PostGIS %s", POSTGIS_VERSION);
  pqsignal(SIGINT, coreIntHandler);

  /* restore original hooks */
  ExecutorStart_hook = onExecutorStartPrev;
}


static void
handleInterrupt(int sig)
{
  /* NOTE: printf here would be dangerous, see
   * https://trac.osgeo.org/postgis/ticket/3644
   *
   * TODO: block interrupts during execution, to fix the problem
   */
  /* printf("Interrupt requested\n"); fflush(stdout); */

  GEOS_interruptRequest();

#ifdef HAVE_LIBPROTOBUF
  lwgeom_wagyu_interruptRequest();
#endif

  /* request interruption of liblwgeom as well */
  lwgeom_request_interrupt();

  if ( coreIntHandler ) {
    (*coreIntHandler)(sig);
  }
}

static void onExecutorStart(QueryDesc *queryDesc, int eflags) {
    /* cancel interrupt requests */

    GEOS_interruptCancel();

#ifdef HAVE_LIBPROTOBUF
    lwgeom_wagyu_interruptReset();
#endif

    lwgeom_cancel_interrupt();

    if (onExecutorStartPrev) {
        (*onExecutorStartPrev)(queryDesc, eflags);
    } else {
        standard_ExecutorStart(queryDesc, eflags);
    }
}
