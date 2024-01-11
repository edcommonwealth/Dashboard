namespace :dashboard do
  desc "Explaining what the task does"
  task :example do
    # Task goes here
    puts "compiling css"
    `yarn build:css`
  end
end
