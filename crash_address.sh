#!/bin/sh

#  crash_address.sh
#  HSNative
#
#  Created by hspcadmin on 2021/10/29.
#  Copyright © 2021 xy2. All rights reserved.


#xcrun atos -o [dwarf文件地址] -arch arm64 -l [loadAddress] [instructionAddress] 。
xcrun atos -o ./dSYMs/Contents/Resources/DWARF/$1 -arch arm64 -l $2 $3


