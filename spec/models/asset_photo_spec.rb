require 'spec_helper'
require 'carrierwave/test/matchers'


describe AssetPhoto do
    include CarrierWave::Test::Matchers

    before do
        AssetPhotoUploader.enable_processing = true
        @workorder = FactoryGirl.create(:workorder)
        @uploader = AssetPhotoUploader.new(@workorder, :photo)
        @uploader.store!(File.open(Rails.root.join('public', 'dgrey076.jpg')))
    end

    after do
        AssetPhotoUploader.enable_processing = false
    end

    it "has a valid factory" do

    end

    context 'the thumb version' do
        it "should scale down image to be no more than 100 x 100 pixels" do
            @uploader.thumb.should be_no_larger_than(100, 100)
        end
    end

    context 'the screen version' do
        it "should scale down image to fit within 1024 by 768 pixels" do
            @uploader.screen.should be_no_larger_than(200, 200)
        end
    end

end
