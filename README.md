# executable-ruby
Cross-compile executables for gem-install process

# How to use
Install golang

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
