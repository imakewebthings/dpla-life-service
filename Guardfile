require 'active_support/core_ext'

guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/routes.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb')
  watch(%r{^spec/support/.+\.rb$})
end

guard 'rspec',
  :version => 2,
  :all_after_pass => false,
  :cli => '--drb' do

  watch(%r{^spec/.+_spec\.rb$})

  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  do |m|
    "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb"
  end

  watch(%r{^app/models/(.+)\.rb$}) do |m|
    "spec/models/#{m[1].singularize}_spec.rb"
  end

  watch(%r{^app/views/(.+)/}) do |m|
    "spec/requests/#{m[1].singularize}_spec.rb"
  end

  watch(%r{^app/mailers/(.+)/}) do |m|
    "spec/mailers/#{m[1].singularize}_spec.rb"
  end
end

