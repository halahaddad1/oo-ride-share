require_relative 'test_helper'

describe "Passenger class" do

  describe "Passenger instantiation" do
    before do
      @passenger = RideShare::Passenger.new(id: 1, name: "Smithy", phone_number: "353-533-5334")
    end

    it "is an instance of Passenger" do
      expect(@passenger).must_be_kind_of RideShare::Passenger
    end

    it "throws an argument error with a bad ID value" do
      expect do
        RideShare::Passenger.new(id: 0, name: "Smithy")
      end.must_raise ArgumentError
    end

    it "sets trips to an empty array if not provided" do
      expect(@passenger.trips).must_be_kind_of Array
      expect(@passenger.trips.length).must_equal 0
    end

    it "is set up for specific attributes and data types" do
      [:id, :name, :phone_number, :trips].each do |prop|
        expect(@passenger).must_respond_to prop
      end

      expect(@passenger.id).must_be_kind_of Integer
      expect(@passenger.name).must_be_kind_of String
      expect(@passenger.phone_number).must_be_kind_of String
      expect(@passenger.trips).must_be_kind_of Array
    end
  end

  describe "trips property" do
    before do
      @passenger = RideShare::Passenger.new(
        id: 9,
        name: "Merl Glover III",
        phone_number: "1-602-620-2330 x3723",
        trips: []
        )

      trip = RideShare::Trip.new(
        id: 8,
        driver_id: 4,
        driver: nil,
        passenger: @passenger,
        start_time: Time.new(2016, 8, 8),
        end_time: Time.new(2016, 8, 9),
        rating: 5,
        cost: 40 
        )

        @passenger.add_trip(trip)

      trip_2 = RideShare::Trip.new(
        id: 777,
        driver_id: 99234,
        driver: nil,
        passenger: @passenger,
        start_time: Time.new(2016, 8, 8),
        end_time: Time.new(2016, 8, 9),
        rating: 5,
        cost: 10, 
        )

      @passenger.add_trip(trip_2)
    end

    it "checks that every item in the Passenger array is a Trip" do
      @passenger.trips.each do |trip|
        expect(trip).must_be_kind_of RideShare::Trip
      end
    end

    it "checks that all Trips have the same Passenger's passenger id" do
      @passenger.trips.each do |trip|
        expect(trip.passenger.id).must_equal 9
      end
    end
  end

  describe "net_expenditures method" do
    before do
      start_time = Time.now - 60 * 60 # 60 minutes
      end_time = start_time + 25 * 60 # 25 minutes
      start_time_2 = Time.now - 60 * 60 # 60 minutes
      end_time_2 = start_time + 30 * 60 # 25 minutes
      start_time_2 = Time.now - 60 * 60 # 60 minutes
      end_time_3 =  nil
      @passenger = RideShare::Passenger.new(
        id: 9,
        name: "Merl Glover III",
        phone_number: "1-602-620-2330 x3723",
        trips: []
      )
      @passenger2 = RideShare::Passenger.new(
        id: 8,
        name: "Merl Glove",
        phone_number: "1-602-620-2330 x3723",
        trips: []
      )
      trip = RideShare::Trip.new(
        id: 8,
        driver_id: 434,
        driver: nil,
        passenger: @passenger,
        start_time: start_time,
        end_time: end_time,
        rating: 5,
        cost: 40
      )
      @passenger.add_trip(trip)

      trip_2 = RideShare::Trip.new(
        id: 777,
        driver_id: 3848534,
        driver: nil,
        passenger: @passenger,
        start_time: start_time_2,
        end_time: end_time_2,
        rating: 5,
        cost: 10
      )
      trip_3 = RideShare::Trip.new(
        id: 777,
        driver_id: 3848534,
        driver: nil,
        passenger: @passenger2,
        start_time: start_time_2,
        end_time: end_time_3,
        rating: 5,
        cost: 10
      )
      @passenger2.add_trip(trip_2)
      @passenger.add_trip(trip_2)
      @passenger2.add_trip(trip_3)
    end

    it "returns the correct total expenditures of a Passenger" do
      expect(@passenger.net_expenditures).must_equal 50
      expect(@passenger2.net_expenditures).must_equal 20
    end
  end

  describe "total_time_spent method" do
    before do
      start_time = Time.now - 60 * 60 # 60 minutes
      end_time = start_time + 25 * 60 # 25 minutes
      start_time_2 = Time.now - 60 * 60 # 60 minutes
      end_time_2 = start_time + 30 * 60 # 25 minutes
      start_time_2 = Time.now - 60 * 60 # 60 minutes
      end_time_3 =  nil
      @passenger = RideShare::Passenger.new(
        id: 9,
        name: "Merl Glover III",
        phone_number: "1-602-620-2330 x3723",
        trips: []
      )
      @passenger2 = RideShare::Passenger.new(
        id: 8,
        name: "Merl Glove",
        phone_number: "1-602-620-2330 x3723",
        trips: []
      )
      trip = RideShare::Trip.new(
        id: 8,
        driver_id: 434,
        driver: nil,
        passenger: @passenger,
        start_time: start_time,
        end_time: end_time,
        rating: 5,
        cost: 40
      )
      @passenger.add_trip(trip)
      @passenger2.add_trip(trip)

      trip_2 = RideShare::Trip.new(
        id: 777,
        driver_id: 3848534,
        driver: nil,
        passenger: @passenger,
        start_time: start_time_2,
        end_time: end_time_2,
        rating: 5,
        cost: 10
      )
      trip_3 = RideShare::Trip.new(
        id: 777,
        driver_id: 3848534,
        driver: nil,
        passenger: @passenger2,
        start_time: start_time_2,
        end_time: end_time_3,
        rating: 5,
        cost: 10
      )
      @passenger.add_trip(trip_2)
      @passenger2.add_trip(trip_3)
    end

    it "returns the total time spent for all of a Passenger's rides" do
      expect(@passenger.total_time_spent).must_equal 3300
    end

    it "returns the total time spent for all of a Passenger's rides" do
      expect(@passenger2.total_time_spent).must_equal 1500
    end
  end
end