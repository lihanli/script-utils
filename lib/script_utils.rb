module ScriptUtils
  module_function

  def run(cmd, output: false, bundle_exec: false, ensure_success: true, working_dir: false)
    cmd = "bundle exec #{cmd}" if bundle_exec
    cmd = "cd #{working_dir}; #{cmd}" if working_dir
    output ? system(cmd) : `#{cmd}`
    raise if ensure_success && !$?.success?
  end

  def files(dir)
    dir = dir[0...-1] if dir.end_with?('/')
    dir = "#{dir}/*"
    Dir[dir].select { |f| File.file?(f) }
  end

  def file_names(dir)
    files(dir).map { |f| File.basename(f) }
  end
end
