require 'spec_helper'

describe SnsCredential do
  pending "add some examples to (or delete) #{__FILE__}"


  #1 バリテーションがかかっている全ての情報があれば登録できること(providerはfacebook)
  it "is valid with a provider, mid, email, uid, token" do
    snscredential = build(:snscredential)
    expect(snscredential).to be_valid
  end

  #2 バリテーションがかかっている全ての情報があれば登録できること(providerはgoogle_oauth2)
  it "is valid with a provider, mid, email, uid, token" do
    snscredential = build(:snscredential, provider: "google_oauth2")
    expect(snscredential).to be_valid
  end

  #3 emailが空だと登録ができない
  it "is invalid without a email" do
    snscredential = build(:snscredential, email: nil)
    snscredential.valid?
    expect(snscredential.errors[:email]).to include("can't be blank")
  end

  #4 uidが空だと登録ができない
  it "is invalid without a uid" do
    snscredential = build(:snscredential, uid: nil)
    snscredential.valid?
    expect(snscredential.errors[:uid]).to include("can't be blank")
  end

end
