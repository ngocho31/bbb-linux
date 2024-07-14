// SPDX-License-Identifier: GPL-2.0
/* hello.c */
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/utsname.h>
#include <linux/timekeeping.h>

static char *whom = "world";
module_param(whom, charp, 0644);
MODULE_PARM_DESC(whom, "Recipient of the hello message");

static int howmany = 1;
module_param(howmany, int, 0644);
MODULE_PARM_DESC(howmany, "Number of greetings");

static time64_t time_start;
static time64_t time_stop;

static int __init hello_init(void)
{
    int i;
    time_start = ktime_get_seconds();

    pr_info("system name = %s\n", utsname()->sysname);
    pr_info("node name   = %s\n", utsname()->nodename);
    pr_info("release     = %s\n", utsname()->release);
    pr_info("machine     = %s\n", utsname()->machine);

    pr_alert("Hello World. You are currently using Linux %s.\n", utsname()->version);

    for (i = 0; i < howmany; i++)
        pr_alert("(%d) Hello, %s\n", i, whom);

    return 0;
}

static void __exit hello_exit(void)
{
    pr_alert("Good bye!\n");
    time_stop = ktime_get_seconds();
    pr_alert("Greeting module run in %llds.\n", time_stop-time_start);
}

module_init(hello_init);
module_exit(hello_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Greeting module");
MODULE_AUTHOR("Ngoc Ho");