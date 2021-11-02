
cd  /Applications/Xcode.app/Contents/SharedFrameworks/CoreSymbolicationDT.framework/Resources/

python3 CrashSymbolicator.py -d $1 -o $2'/CrashLog.crash' -p $3
