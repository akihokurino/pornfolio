set :output, {:error => 'log/error.log', :standard => 'log/cron.log'}
set :environment, :production

job_type :original_ruby_runner, "export PATH=\"/usr/local/bin:$PATH\"; cd :path && bin/rails runner -e :environment ':task' :output"


every 1.day, :at => '9:30 am' do
  original_ruby_runner "Tasks::Ranking.tally"
end