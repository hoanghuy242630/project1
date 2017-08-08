require "rails_helper"

RSpec.describe SessionsHelper, type: :helper do
  describe "#current_user" do
    let :user {FactoryGirl.create :user}
    context "when session is nill and have remember token" do
      subject {current_user}
      before do
        remember user
      end

      it {is_expected.to eq user}
    end

    context "remember digest is wrong" do
      subject {current_user}
      before do
        remember user
        user.remember_digest = User.digest User.new_token
        user.save
      end

      it {is_expected.to eq nil}
    end
  end
end
