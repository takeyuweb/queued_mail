
def file_read(name)
  File.read File.join(File.dirname(__FILE__), '../files', name)
end
