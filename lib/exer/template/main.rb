# frozen_string_literal: true

# Copyright (C) 2022  Aleksandar Subasic

module Template
  # Main functions in golang file.
  MAIN_FUNCTION = {
    binary_exist: 'BinaryExist("COMMAND")',
    ruby_exist: 'RubyExist()',
    ruby_exec: 'RubyExec("COMMAND")',
    gem_install: 'GemInstall("COMMAND")',
    gem_run: 'GemRun("COMMAND")'
  }.freeze

  # Wait for user to press enter before exit.
  # Useful only when you install gem without running.
  #
  WAIT_FOR_ENTER =
    <<~CODE

       fmt.Println("")
       fmt.Println("Press [ENTER] key to exit")
      var reader = bufio.NewReader(os.Stdin)
      reader.ReadString('\\n')
    CODE
end
