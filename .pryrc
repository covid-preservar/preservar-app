COLORS = { production: "\001\e[1m\e[31m\002",
           development: "\001\e[1m\e[32m\002",
           staging: "\001\e[1m\e[33m\002" }

if Object.const_defined?('Rails')
  prompt = case Rails.env
    when 'development'
      [COLORS[:development], 'dev']
    when 'production'
      ENV['HEROKU_APP_NAME'] =~ /qa|test/ ? [COLORS[:staging], ENV['HEROKU_APP_NAME']] : [COLORS[:production], 'PROD']
    else
      [COLORS[:staging], ENV['HEROKU_APP_NAME'] || 'pry']
    end
else
  prompt = [COLORS[:development], 'pry']
end

Pry.config.prompt_name = "#{prompt.first}#{prompt.last}\001\e[0m\002"

if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end