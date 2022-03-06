# frozen_string_literal: true

# Copyright (C) 2022  Aleksandar Subasic

# Set of predefined functions in go language.
# Consist of function definitions, and main function
# that run it.
#
module Template
  # make private to avoid yard generation
  private

  Go_Packages =
    <<~CODE
      package main
      import ("bufio"; "bytes"; "fmt"; "os"; "os/exec")
    CODE

  Ruby_Exist =
    <<~CODE
      func RubyExist() (string, error) {
        rbin, rerr := BinaryExist("ruby")

        if rerr == nil {
            RubyExec("print '[+] Ruby Version: ' + RUBY_VERSION")
            RubyExec("print '[+] Ruby Platform: ' + RUBY_PLATFORM")
        } else {
            fmt.Println("Error:", rerr)
            os.Exit(1)
        }
        return rbin, rerr
      }
    CODE

  Ruby_Exec =
    <<~CODE
      func RubyExec(command string) (string, string, error) {
        var stdout bytes.Buffer
        var stderr bytes.Buffer

        cmd := exec.Command("ruby", "-e", command)

        cmd.Stdout = &stdout
        cmd.Stderr = &stderr
        err := cmd.Run()

        sout := stdout.String()
        serr := stderr.String()

        if err == nil {
            fmt.Println(sout)
        } else {
            fmt.Println("Error:", serr, err)
        }
        return sout, serr, err
      }
    CODE

  Gem_Install =
    <<~CODE
      func GemInstall(gem string) (string, string, error) {
        _, gerr := BinaryExist("gem")
        if gerr != nil { fmt.Println(gerr); os.Exit(1) }

        var stdout bytes.Buffer
        var stderr bytes.Buffer

        cmd := exec.Command("gem", "install", gem)

        cmd.Stdout = &stdout
        cmd.Stderr = &stderr
        err := cmd.Run()

        sout := stdout.String()
        serr := stderr.String()

        if err == nil {
            fmt.Println(sout)
        } else {
            fmt.Println("Error:", serr, err)
        }
        return sout, serr, err
      }
    CODE

  Binary_Exist =
    <<~CODE
      func BinaryExist(binary string) (string, error) {
        path, err := exec.LookPath(binary)
        if err == nil {
            fmt.Println("[+] Found", binary, "binary:", path)
        } else {
            fmt.Println("[-]", binary, "binary not found in path")
        }
        return path, err
      }
    CODE

  # generate yard doc for ruby code
  public

  # Predefined functions in golang. go_packages is always first.
  FUNCTION = {
    go_packages: Go_Packages,
    ruby_exist: Ruby_Exist,
    binary_exist: Binary_Exist,
    ruby_exec: Ruby_Exec,
    gem_install: Gem_Install
  }.freeze
end
