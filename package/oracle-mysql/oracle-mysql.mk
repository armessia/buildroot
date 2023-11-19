################################################################################
#
# oracle-mysql
#
################################################################################

ORACLE_MYSQL_VERSION_MAJOR = 8.2
ORACLE_MYSQL_VERSION = $(ORACLE_MYSQL_VERSION_MAJOR).0
ORACLE_MYSQL_SOURCE = mysql-$(ORACLE_MYSQL_VERSION).tar.gz
ORACLE_MYSQL_SITE = http://dev.mysql.com/get/Downloads/MySQL-$(ORACLE_MYSQL_VERSION_MAJOR)
ORACLE_MYSQL_INSTALL_STAGING = YES
ORACLE_MYSQL_DEPENDENCIES = libevent libtirpc ncurses openssl
ORACLE_MYSQL_SUPPORTS_IN_SOURCE_BUILD = NO
ORACLE_MYSQL_LICENSE = GPL-2.0
ORACLE_MYSQL_LICENSE_FILES = README COPYING
ORACLE_MYSQL_CPE_ID_VENDOR = oracle
ORACLE_MYSQL_CPE_ID_PRODUCT = mysql
ORACLE_MYSQL_SELINUX_MODULES = mysql
ORACLE_MYSQL_PROVIDES = mysql
ORACLE_MYSQL_CONFIG_SCRIPTS = mysql_config

# Unix socket. This variable can also be consulted by other buildroot packages
MYSQL_SOCKET = /run/mysql/mysql.sock

ORACLE_MYSQL_CONF_OPTS = \
	-DDOWNLOAD_BOOST=1 \
	-DWITH_BOOST=$(@D)/boost \
	-DWITH_LIBEVENT=system \
	-DWITH_UNIT_TESTS=OFF

# Fix try_run() invokations
ORACLE_MYSQL_CONF_OPTS += \
	-DHAVE_C_FLOATING_POINT_FUSED_MADD_EXITCODE=0 \
	-DHAVE_CXX_FLOATING_POINT_FUSED_MADD_EXITCODE=0 \
	-DHAVE_SETNS_EXITCODE=0 \
	-DHAVE_CLOCK_GETTIME_EXITCODE=0 \
	-DHAVE_CLOCK_REALTIME_EXITCODE=0 \
	-DHAVE_FALLOC_PUNCH_HOLE_AND_KEEP_SIZE_EXITCODE=0 \
	-DHAVE___BUILTIN_FFS_EXITCODE=0

define ORACLE_MYSQL_USERS
	mysql -1 nobody -1 * /var/mysql - - MySQL daemon
endef

define ORACLE_MYSQL_ADD_FOLDER
	$(INSTALL) -d $(TARGET_DIR)/var/mysql
endef

ORACLE_MYSQL_POST_INSTALL_TARGET_HOOKS += ORACLE_MYSQL_ADD_FOLDER

define ORACLE_MYSQL_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(ORACLE_MYSQL_PKGDIR)/S97mysqld \
		$(TARGET_DIR)/etc/init.d/S97mysqld
endef

define ORACLE_MYSQL_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(ORACLE_MYSQL_PKGDIR)/mysqld.service \
		$(TARGET_DIR)/usr/lib/systemd/system/mysqld.service
endef

$(eval $(cmake-package))
