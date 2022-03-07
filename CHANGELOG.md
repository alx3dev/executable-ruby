## [in-development]

 - fix `Could not locate Gemfile` when installed from _rubygems_.
 - fix `wget` not installed on the system - install if not found.
 - change method name from `Exer::Make#make` to `Exer::Make#build`
 - remove attribute `Exer::Make#file`
 - Add attributes `#functions` and `#main` to `Exer::Make`
 - refactor code to use private methods, for easier upgrade in future
