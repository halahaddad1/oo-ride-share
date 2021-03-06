require_relative 'test_helper'

describe "Trip class" do
  describe "initialize" do
    before do
      start_time = Time.now - 60 * 60 # 60 minutes
      end_time = start_time + 25 * 60 # 25 minutes
    
      @trip_data = {
        id: 8,
        driver: RideShare::Driver.new(
                                    id:2,
                                    name: "Anton",
                                    vin: "12345678910111213",
                                    status: :AVAILABLE,
                                    trips: []
        ),
        passenger: RideShare::Passenger.new(
          id: 1,
          name: "Amos",
          phone_number: "412-432-7640"
        ),
        start_time: start_time,
        end_time: end_time,
        cost: 23.45,
        rating: 3
      }
      @trip = RideShare::Trip.new(@trip_data)
    end
    
    it "start time should come before end time" do
      expect{RideShare::Trip.new(@trip)}.must_raise ArgumentError
    end

    it "is an instance of Trip" do
      expect(@trip).must_be_kind_of RideShare::Trip
    end

    it "start_time is an instance of Time" do
      expect(@trip.start_time).must_be_kind_of Time
    end

    it "end_time is an instance of Time" do
      expect(@trip.end_time).must_be_kind_of Time
    end

    it "stores an instance of passenger" do
      expect(@trip.passenger).must_be_kind_of RideShare::Passenger
    end

    it "stores an instance of driver" do
      expect(@trip.driver).must_be_kind_of RideShare::Driver
    end

    it "raises an error for an invalid rating" do
      [-3, 0, 6].each do |rating|
        @trip_data[:rating] = rating
        expect do
          RideShare::Trip.new(@trip_data)
        end.must_raise ArgumentError
      end
    end
  end

  describe "trip_duration" do 
    before do
      start_time = Time.now - 60 * 60 # 60 minutes
      end_time = start_time + 25 * 60 # 25 minutes
   
     @trip_data = {
       id: 8,
       passenger: RideShare::Passenger.new(
                                          id: 1,
                                          name: "Ada",
                                          phone_number: "412-432-7640"
       ),
       start_time: start_time,
       end_time: end_time,
       cost: 23.45,
       rating: 3, 
       driver_id: 9913,
       driver: nil
     }
     @trip = RideShare::Trip.new(@trip_data)
    end

    it "calculates the duration of the trip in seconds" do
      expect(@trip.trip_duration).must_equal 1500
    end
  end
end
