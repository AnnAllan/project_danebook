require 'rails_helper'
require 'support/factory_girl'

describe Like do

  let(:user){build(:user)}
  let(:post_like){build(:post_like)}
  let(:comment_like){build(:comment_like)}

  it "can be added to a post" do
    expect(post_like.likable).to be_a(Post)
  end

  it "can be added to a comment" do
    expect(comment_like.likable).to be_a(Comment)
  end

  it "cannot be place by the same user on the same thing twice" do
    old_like = build(:post_like, likable_id: 1, likable_type: "Post",
                    user_id: 1)
    old_like.save
    new_like = build(:post_like, likable_id: 1, likable_type: "Post",               user_id: 1)
    expect(new_like).not_to be_valid
  end
end
