# frozen_string_literal: true

# Copyright (C) 2022  Aleksandar Subasic

module Template
  # Main functions in golang file.
  MAIN_FUNCTION = {
    ruby_exist: '  RubyExist()',
    binary_exist: '  BinaryExist("COMMAND")',
    git_exist: '  BinaryExist("git")',
    ruby_exec: '  RubyExec("COMMAND")',
    gem_install: '  GemInstall("COMMAND")'
  }.freeze

  # Wait for user to press enter before exit.
  # We need it to show error if something goes wrong,
  # otherwise it'd just exit before user even see an error occurred.
  #
  WAIT_FOR_ENTER_TO_EXIT =
    <<~CODE

        fmt.Println("")
        fmt.Println("Press [ENTER] key to exit")

      	var reader = bufio.NewReader(os.Stdin)
      	reader.ReadString('\\n')
      }
    CODE
end
