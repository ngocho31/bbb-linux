// SPDX-License-Identifier: GPL-2.0
/*
 * From split of dump_linuxpagetables.c
 * Copyright 2016, Rashmica Gupta, IBM Corp.
 *
 */
#include <linux/kernel.h>
#include <linux/pgtable.h>

#include "ptdump.h"

static const struct flag_info flag_array[] = {
	{
		.mask	= _PAGE_READ,
		.val	= 0,
		.set	= " ",
		.clear	= "r",
	}, {
		.mask	= _PAGE_WRITE,
		.val	= 0,
		.set	= " ",
		.clear	= "w",
	}, {
		.mask	= _PAGE_EXEC,
		.val	= _PAGE_EXEC,
		.set	= " X ",
		.clear	= "   ",
	}, {
		.mask	= _PAGE_PRESENT,
		.val	= _PAGE_PRESENT,
		.set	= "present",
		.clear	= "       ",
	}, {
		.mask	= _PAGE_COHERENT,
		.val	= _PAGE_COHERENT,
		.set	= "coherent",
		.clear	= "        ",
	}, {
		.mask	= _PAGE_GUARDED,
		.val	= _PAGE_GUARDED,
		.set	= "guarded",
		.clear	= "       ",
	}, {
		.mask	= _PAGE_DIRTY,
		.val	= _PAGE_DIRTY,
		.set	= "dirty",
		.clear	= "     ",
	}, {
		.mask	= _PAGE_ACCESSED,
		.val	= _PAGE_ACCESSED,
		.set	= "accessed",
		.clear	= "        ",
	}, {
		.mask	= _PAGE_WRITETHRU,
		.val	= _PAGE_WRITETHRU,
		.set	= "write through",
		.clear	= "             ",
	}, {
		.mask	= _PAGE_NO_CACHE,
		.val	= _PAGE_NO_CACHE,
		.set	= "no cache",
		.clear	= "        ",
	}, {
		.mask	= _PAGE_SPECIAL,
		.val	= _PAGE_SPECIAL,
		.set	= "special",
	}
};

struct pgtable_level pg_level[5] = {
	{ /* pgd */
		.flag	= flag_array,
		.num	= ARRAY_SIZE(flag_array),
	}, { /* p4d */
		.flag	= flag_array,
		.num	= ARRAY_SIZE(flag_array),
	}, { /* pud */
		.flag	= flag_array,
		.num	= ARRAY_SIZE(flag_array),
	}, { /* pmd */
		.flag	= flag_array,
		.num	= ARRAY_SIZE(flag_array),
	}, { /* pte */
		.flag	= flag_array,
		.num	= ARRAY_SIZE(flag_array),
	},
};