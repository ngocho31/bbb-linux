// SPDX-License-Identifier: GPL-2.0
/* hello.c */
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/utsname.h>

static int __init hello_init(void)
{
    pr_info("system name = %s\n", utsname()->sysname);
    pr_info("node name   = %s\n", utsname()->nodename);
    pr_info("release     = %s\n", utsname()->release);
    pr_info("machine     = %s\n", utsname()->machine);

    pr_alert("Hello World. You are currently using Linux %s.\n", utsname()->version);

    return 0;
}

static void __exit hello_exit(void)
{
    pr_alert("Good bye!\n");
}

module_init(hello_init);
module_exit(hello_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Greeting module");
MODULE_AUTHOR("Ngoc Ho");