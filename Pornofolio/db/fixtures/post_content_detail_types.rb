%w(
xvideos
agesage
image
header
description
source
twitter
text
).each do |name|
  PostContentDetailType.seed(:name) do |s|
    s.name = name
  end
end