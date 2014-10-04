%w(
general
advertisement
).each do |name|
  PostType.seed(:name) do |s|
    s.name = name
  end
end