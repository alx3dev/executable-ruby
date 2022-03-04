# executable-ruby
Cross-compile executables for gem-install process

A Work In Progress...

# How to use
Install golang. Future plans are to build everything together, to avoid go-lang requirement.

```ruby
bin/exer

Exer.make(filename: 'glimmer-install', exclude: :darwin) do |x|
  x.add :gem_install, 'glimmer-dsl-libui'
end
```

```ruby
Exer.make do |app|
  app.filename = 'glimmer-dsl-libui'
  app.add :binary_exist, 'git'
  app.add :gem_install, 'glimmer-dsl-libui'
end
```
