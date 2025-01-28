@echo off

set arg1=%~1

if "%arg1%" == "" (
  goto without_commit
) else (
  goto with_commit
)

:with_commit
SET comment=%1
CALL :github_setting
CALL :commit %comment%
CALL :push
CALL :gitlab_settings
CALL :push
EXIT /B 0

:without_commit
CALL :github_setting
CALL :push
CALL :gitlab_settings
CALL :push
EXIT /B 0



@REM UTILS
:github_setting
CALL :configure "proger0014" "iakov56@yandex.ru" "https://github.com/Proger0014/jobtests-products-crud.git"
EXIT /B 0

:gitlab_settings
CALL :configure "Iakov Kostenyuk" "iakov.kostenyuk@gmail.com" "https://gitlab.com/proger0014-jobtests/table-cells-processor.git"
EXIT /B 0

@REM %~1 - user.name
@REM %~2 - user.email
@REM %~3 - remote origin
:configure
CALL git config --local --replace-all user.name "%~1"
CALL git config --local --replace-all user.email "%~2"
CALL git remote set-url origin "%~3"
EXIT /B 0

:push
CALL git push -u origin main
EXIT /B 0


@REM %~1 - comment
:commit
CALL git add .
CALL git commit -m "%~1"
EXIT /B 0