module StringMonkeyPatches
  def valid_likert_score?
    to_i.between? 1, 5
  end
end

String.include StringMonkeyPatches
