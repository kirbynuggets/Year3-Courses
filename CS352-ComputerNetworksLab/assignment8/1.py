import random


def csma_cd_simulation(N, T):
    slots = [0] * T  # To keep track of transmissions in each slot
    station_states = [False] * N  # Whether a station has successfully transmitted
    transmission_times = [-1] * N  # time slot at which each station successfully transmits

    for slot in range(T):
        transmitting_stations = []

        # Stations sense the medium
        for station in range(N):
            if not station_states[station]:  # If station hasn't transmitted yet
                if all([slots[prev] == 0 for prev in range(slot)]):  # Channel idle
                    transmitting_stations.append(station)

        # Handle collisions or successful transmission
        if len(transmitting_stations) == 1:  # No collision, successful transmission
            station = transmitting_stations[0]
            transmission_times[station] = slot
            station_states[station] = True
            slots[slot] = station + 1
        elif len(transmitting_stations) > 1:  # Collision detected
            print(f"Collision detected at slot {slot}")
            # Backoff logic: select random backoff time for each station
            for station in transmitting_stations:
                backoff_time = random.randint(1, 10)  # Example range
                print(f"Station {station + 1} will back off for {backoff_time} slots")

    # Print the results
    for station in range(N):
        if transmission_times[station] != -1:
            print(f"Station {station + 1} successfully transmitted at slot {transmission_times[station]}")
        else:
            print(f"Station {station + 1} failed to transmit within {T} slots")


# Main program to accept user input
if __name__ == "__main__":
    # Get the number of stations and time slots from the user
    N = int(input("Enter the number of stations (N): "))
    T = int(input("Enter the number of time slots (T): "))

    # Call the simulation function
    csma_cd_simulation(N, T)
