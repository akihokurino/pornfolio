%w(
view
).each do |name|
  PostAnalysisType.seed(:name) do |s|
    s.name = name
  end
end