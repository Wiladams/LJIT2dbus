local ffi = require("ffi")

require("dbus-macros")
require("dbus-types")


ffi.cdef[[
/** An opaque mutex type provided by the #DBusThreadFunctions implementation installed by dbus_threads_init(). */
typedef struct DBusMutex DBusMutex;
/** An opaque condition variable type provided by the #DBusThreadFunctions implementation installed by dbus_threads_init(). */
typedef struct DBusCondVar DBusCondVar;
]]

--[[
/** Deprecated, provide DBusRecursiveMutexNewFunction instead. */
typedef DBusMutex*  (* DBusMutexNewFunction)    (void);
/** Deprecated, provide DBusRecursiveMutexFreeFunction instead. */
typedef void        (* DBusMutexFreeFunction)   (DBusMutex *mutex);
/** Deprecated, provide DBusRecursiveMutexLockFunction instead. Return value is lock success, but gets ignored in practice. */
typedef dbus_bool_t (* DBusMutexLockFunction)   (DBusMutex *mutex);
/** Deprecated, provide DBusRecursiveMutexUnlockFunction instead. Return value is unlock success, but gets ignored in practice. */
typedef dbus_bool_t (* DBusMutexUnlockFunction) (DBusMutex *mutex);
--]]

ffi.cdef[[

typedef DBusMutex*  (* DBusRecursiveMutexNewFunction)    (void);

typedef void        (* DBusRecursiveMutexFreeFunction)   (DBusMutex *mutex);

typedef void        (* DBusRecursiveMutexLockFunction)   (DBusMutex *mutex);

typedef void        (* DBusRecursiveMutexUnlockFunction) (DBusMutex *mutex);
]]

ffi.cdef[[
typedef DBusCondVar*  (* DBusCondVarNewFunction)         (void);

typedef void          (* DBusCondVarFreeFunction)        (DBusCondVar *cond);

typedef void          (* DBusCondVarWaitFunction)        (DBusCondVar *cond,
							  DBusMutex   *mutex);

typedef dbus_bool_t   (* DBusCondVarWaitTimeoutFunction) (DBusCondVar *cond,
							  DBusMutex   *mutex,
							  int          timeout_milliseconds);

typedef void          (* DBusCondVarWakeOneFunction) (DBusCondVar *cond);

typedef void          (* DBusCondVarWakeAllFunction) (DBusCondVar *cond);
]]

ffi.cdef[[
/**
 * Flags indicating which functions are present in #DBusThreadFunctions. Used to allow
 * the library to detect older callers of dbus_threads_init() if new possible functions
 * are added to #DBusThreadFunctions.
 */
typedef enum 
{
  DBUS_THREAD_FUNCTIONS_MUTEX_NEW_MASK      = 1 << 0,
  DBUS_THREAD_FUNCTIONS_MUTEX_FREE_MASK     = 1 << 1,
  DBUS_THREAD_FUNCTIONS_MUTEX_LOCK_MASK     = 1 << 2,
  DBUS_THREAD_FUNCTIONS_MUTEX_UNLOCK_MASK   = 1 << 3,
  DBUS_THREAD_FUNCTIONS_CONDVAR_NEW_MASK    = 1 << 4,
  DBUS_THREAD_FUNCTIONS_CONDVAR_FREE_MASK   = 1 << 5,
  DBUS_THREAD_FUNCTIONS_CONDVAR_WAIT_MASK   = 1 << 6,
  DBUS_THREAD_FUNCTIONS_CONDVAR_WAIT_TIMEOUT_MASK   = 1 << 7,
  DBUS_THREAD_FUNCTIONS_CONDVAR_WAKE_ONE_MASK = 1 << 8,
  DBUS_THREAD_FUNCTIONS_CONDVAR_WAKE_ALL_MASK = 1 << 9,
  DBUS_THREAD_FUNCTIONS_RECURSIVE_MUTEX_NEW_MASK    = 1 << 10,
  DBUS_THREAD_FUNCTIONS_RECURSIVE_MUTEX_FREE_MASK   = 1 << 11,
  DBUS_THREAD_FUNCTIONS_RECURSIVE_MUTEX_LOCK_MASK   = 1 << 12,
  DBUS_THREAD_FUNCTIONS_RECURSIVE_MUTEX_UNLOCK_MASK = 1 << 13,
  DBUS_THREAD_FUNCTIONS_ALL_MASK     = (1 << 14) - 1
} DBusThreadFunctionsMask;

/**
 * Functions that must be implemented to make the D-Bus library
 * thread-aware.
 *
 * If you supply both recursive and non-recursive mutexes,
 * libdbus will use the non-recursive version for condition variables,
 * and the recursive version in other contexts.
 *
 * The condition variable functions have to work with nonrecursive
 * mutexes if you provide those, or with recursive mutexes if you
 * don't.
 */
typedef struct
{
  unsigned int mask; /**< Mask indicating which functions are present. */

  DBusMutexNewFunction mutex_new; /**< Function to create a mutex; optional and deprecated. */
  DBusMutexFreeFunction mutex_free; /**< Function to free a mutex; optional and deprecated. */
  DBusMutexLockFunction mutex_lock; /**< Function to lock a mutex; optional and deprecated. */
  DBusMutexUnlockFunction mutex_unlock; /**< Function to unlock a mutex; optional and deprecated. */

  DBusCondVarNewFunction condvar_new; /**< Function to create a condition variable */
  DBusCondVarFreeFunction condvar_free; /**< Function to free a condition variable */
  DBusCondVarWaitFunction condvar_wait; /**< Function to wait on a condition */
  DBusCondVarWaitTimeoutFunction condvar_wait_timeout; /**< Function to wait on a condition with a timeout */
  DBusCondVarWakeOneFunction condvar_wake_one; /**< Function to wake one thread waiting on the condition */
  DBusCondVarWakeAllFunction condvar_wake_all; /**< Function to wake all threads waiting on the condition */
 
  DBusRecursiveMutexNewFunction recursive_mutex_new; /**< Function to create a recursive mutex */
  DBusRecursiveMutexFreeFunction recursive_mutex_free; /**< Function to free a recursive mutex */
  DBusRecursiveMutexLockFunction recursive_mutex_lock; /**< Function to lock a recursive mutex */
  DBusRecursiveMutexUnlockFunction recursive_mutex_unlock; /**< Function to unlock a recursive mutex */

  void (* padding1) (void); /**< Reserved for future expansion */
  void (* padding2) (void); /**< Reserved for future expansion */
  void (* padding3) (void); /**< Reserved for future expansion */
  void (* padding4) (void); /**< Reserved for future expansion */
  
} DBusThreadFunctions;
]]

ffi.cdef[[

dbus_bool_t  dbus_threads_init         (const DBusThreadFunctions *functions);

dbus_bool_t  dbus_threads_init_default (void);
]]
