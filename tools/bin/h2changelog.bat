@echo off
if "%OS%" == "Windows_NT" setlocal

setlocal enabledelayedexpansion

rem %~dp0 is expanded pathname of the current script under NT
set H2_HOME=%~dp0

set DBNAME=test
if ""%1""=="""" goto done
set DBNAME=%1
:done

@java -cp "%H2_HOME%..\lib\h2-1.3.166x.jar;%CLASSPATH%" org.h2.tools.Shell ^
      -url jdbc:h2:file:%DBNAME% ^
      -driver org.h2.Driver ^
      -user sa ^
      -password sa ^
      -list ^
      -sql "SELECT * FROM DATABASECHANGELOG"

@if errorlevel 1 pause