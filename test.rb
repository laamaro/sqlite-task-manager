require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative 'task'

# READ(ONE)
# task = Task.find(2)
# puts "#{task.title} - #{task.description}"

# CREATE
# task = Task.new(title: 'Estudar um pouco', description: 'Não vamos fazer isso hoje!')
# task.save

# UPDATE
# task = Task.find(1)
# task.done!
# task.save

# DELETE
# task = Task.find(7)
# task.destroy

# READ(ALL)
# Task.all.each do |task|
#   puts "[#{task.done? ? 'X' : ' '}]#{task.title}: #{task.description} "
# end
