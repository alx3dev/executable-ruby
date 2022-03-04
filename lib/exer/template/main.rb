# Copyright (C) 2022  Aleksandar Subasic
# frozen_string_literal: true

module Template
  Main_Function = {
    ruby_exist: '  RubyExist()',
    binary_exist: '  BinaryExist("COMMAND")',
    git_exist: '  BinaryExist("git")',
    ruby_exec: '  RubyExec("COMMAND")',
    gem_install: '  GemInstall("COMMAND")'
  }

  Finalize_Main =
    <<~CODE.freeze
 
        fmt.Println("")
        fmt.Println("Press [ENTER] key to exit")

      	var reader = bufio.NewReader(os.Stdin)
      	reader.ReadString('#{'\n'}')
      }
    CODE
end
