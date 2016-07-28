# Copyright (C) 2013-2016  CEA/DEN, EDF R&D
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
#
# See http://www.salome-platform.org/ or email : webmaster.salome@opencascade.com
#

# - Find MESHGEMS
# Sets the following variables:
#   MESHGEMS_INCLUDE_DIRS - path to the MESHGEMS include directory
#   MESHGEMS_LIBRARIES    - path to the MESHGEMS libraries to be linked against

# ------

MESSAGE(STATUS "Check for MESHGEMS ...")

# ------

SET(MESHGEMS_ROOT_DIR $ENV{MESHGEMS_ROOT_DIR})

IF(MESHGEMS_ROOT_DIR)
  LIST(APPEND CMAKE_PREFIX_PATH "${MESHGEMS_ROOT_DIR}")
ENDIF(MESHGEMS_ROOT_DIR)

FIND_PATH(MESHGEMS_INCLUDE_DIRS meshgems/cadsurf.h PATH_SUFFIXES include)

IF(MACHINE_IS_64)
  SET(_suff "_64")
ELSE()
  SET(_suff)
ENDIF(MACHINE_IS_64)
IF(WIN32)	
  SET(_plt WinXP${_suff}_VC9 WinXP${_suff}_VC10)
ELSE()
  SET(_plt Linux${_suff})
ENDIF(WIN32)

FIND_LIBRARY(MESHGEMS_LIBRARY_mg-cadsurf NAMES mg-cadsurf PATH_SUFFIXES ${_plt})
FIND_LIBRARY(MESHGEMS_LIBRARY_mg-precad NAMES mg-precad PATH_SUFFIXES ${_plt})
FIND_LIBRARY(MESHGEMS_LIBRARY_meshgems NAMES meshgems PATH_SUFFIXES ${_plt})

# TODO: search all components
SET(MESHGEMS_LIBRARIES)
SET(MESHGEMS_LIBRARIES ${MESHGEMS_LIBRARIES} ${MESHGEMS_LIBRARY_mg-cadsurf})
SET(MESHGEMS_LIBRARIES ${MESHGEMS_LIBRARIES} ${MESHGEMS_LIBRARY_mg-precad})
IF(MESHGEMS_LIBRARY_meshgems)
  SET(MESHGEMS_LIBRARIES ${MESHGEMS_LIBRARIES} ${MESHGEMS_LIBRARY_meshgems})
ENDIF(MESHGEMS_LIBRARY_meshgems)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(MESHGEMS REQUIRED_VARS MESHGEMS_INCLUDE_DIRS MESHGEMS_LIBRARIES)