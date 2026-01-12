setenv bootargs console=ttyS0,115200 root=/dev/mmcblk0p1 rootwait
load mmc 0:1 $kernel_addr_r boot/Image
load mmc 0:1 $fdt_addr_r boot/sun55i-a527-cubie-a5e.dtb
booti $kernel_addr_r - $fdt_addr_r
