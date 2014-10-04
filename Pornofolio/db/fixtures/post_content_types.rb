%w(
video
header
quotation
image
link
sns
text
).each do |name|
  PostContentType.seed(:name) do |s|
    s.name = name
  end
end