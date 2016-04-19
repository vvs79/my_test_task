class ApplicationMailer < ActionMailer::Base
  default from: "my.test.task.info@gmail.com", template_path: 'mailers/users'
end
