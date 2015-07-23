module ScriptUtils
  module_function

  def run(cmd, output: false, bundle_exec: false, ensure_success: true, working_dir: false)
    cmd = "bundle exec #{cmd}" if bundle_exec
    cmd = "cd #{working_dir}; #{cmd}" if working_dir
    output ? system(cmd) : `#{cmd}`
    raise if ensure_success && !$?.success?
  end

  %w[files directories].each do |type|
    singular = type == 'files' ? 'file' : 'directory'

    define_method(type) do |dir|
      dir = dir[0...-1] if dir.end_with?('/')
      dir = "#{dir}/*"

      Dir[dir].find_all do |file_or_dir|
        File.public_send("#{singular}?", file_or_dir)
      end
    end

    define_method("#{singular}_names") do |dir|
      public_send(type, dir).map { |f| File.basename(f) }
    end
  end
end
