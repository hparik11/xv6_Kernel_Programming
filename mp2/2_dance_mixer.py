from itertools import cycle
from collections import deque
from threading import Thread, Semaphore
from time import sleep
from random import random




def get_leader(id):
    return "Leader %d" % (id)

def get_follower(id):
    return "Follower %d" % (id)

def queue_making():
    
    global l_count
    global f_count
    for i in range(l_count):
        l_queue.append(i)
        
    for i in range(f_count):
        f_queue.append(i)
        

def start_music(music):
    print "** Band leader started playing %s  **" %music

def end_music(music):
    print "** Band leader stopped playing %s  **" %music
    

def enter_floor(person):
    
    global floor_person_count
    
    music_changing.acquire()
    music_changing.release()

    floor_person_count_mutex.acquire()
    if floor_person_count == 0:                             #essential condition for starting music
        music_starts.acquire()
        floor_empty.acquire()
        
    floor_person_count += 1
    floor_person_count_mutex.release()
        
    print  "%s entering floor" %person


def making_pair():
    
    global pair_count
    
    
    pair_mutex.acquire()
    pair_count += 1
    if pair_count == 2:                                             
        turnstile2.acquire()
        turnstile.release()
    pair_mutex.release()
    
    turnstile.acquire()
    turnstile.release()
    
    pair_mutex.acquire()
    pair_count -=1
    
    if pair_count == 0:
        print get_leader(cur_leader)," and ", get_follower(cur_follower), " are dancing..."
        turnstile.acquire()
        turnstile2.release()
        
    pair_mutex.release()
    
    turnstile2.acquire()
    turnstile2.release()
    

def line_up(person):
    
    global floor_person_count
    
    floor_person_count_mutex.acquire()
    floor_person_count -= 1
    
    print "%s getting back in line" %person 
   
    if floor_person_count == 0:
        floor_empty.release()
     
    floor_person_count_mutex.release()    


def leader(id):
    
    global cur_leader 
    global cur_follower
    
    
    while True:
    
        l_mutex.acquire()
        l_queue_mutex.acquire()
        l_id = l_queue.popleft()                         #Pop first leader in queue
        l_queue.appendleft(l_id)
            
        
        if l_id != id:
            
            l_queue_mutex.release()
            l_mutex.release()
            continue
        
        l_queue_mutex.release()
        
        pair_leader.release()
        pair_follower.acquire()
    
        cur_leader = l_id
        
        
        enter_floor(get_leader(cur_leader))              #Current leader in entering floor
        
        l_queue_mutex.acquire()
        l_queue.popleft()
        l_queue_mutex.release()
        
        making_pair()                                  #making pair of leader and follower
        
        l_mutex.release();
        
        sleep(3)                                              #Dancing time for pair
        
        l_queue_mutex.acquire()
        l_queue.append(l_id)
        line_up(get_leader(l_id))                      # Again Back to line after dancing.
        l_queue_mutex.release();
       
    
def follower(id):
    
    
    global cur_pair_count
    global cur_leader
    global cur_follower
    
    while True:
        
        f_mutex.acquire()
        f_queue_mutex.acquire()
        f_id = f_queue.popleft()
        f_queue.appendleft(f_id)                        # Followers are in queue at the start.  
        
        if f_id != id:
            f_queue_mutex.release()
            f_mutex.release()
            continue
        
        f_queue_mutex.release()
        
        pair_follower.release()
        pair_leader.acquire()
        
        
        cur_follower = f_id
        
        
        enter_floor(get_follower(cur_follower))            #Current follower in entering floor
        
        f_queue_mutex.acquire()
        f_queue.popleft()
        f_queue_mutex.release()
        
        making_pair()                                     #making pair of leader and follower
        
        f_mutex.release();
        
        sleep(3)                                            #Dancing time for pair
        
        f_queue_mutex.acquire()
        f_queue.append(f_id)                                #appending follower at the end. 
        line_up(get_follower(f_id))                         # Again Back to line after dancing.
        f_queue_mutex.release();

        
def band_leader():
    
    for music in cycle(['waltz', 'tango', 'foxtrot']):
        
        start_music(music)                                     #Starts music 
        music_starts.release()
        
        sleep(time_per_music)                                  #Sleep while music is on.
        
        music_changing.acquire()
        floor_empty.acquire()                                  #Checking whether floor is empty or not.
        
            
        end_music(music)                                       #Ends music                                  
        
        
        floor_empty.release()
        music_changing.release()       


if __name__ == '__main__':
    
        
    time_per_music = 5                                             #Initially fixed it.

    l_count = int(raw_input("Enter number of Leaders "))
    f_count = int(raw_input("Enter number of Followers "))


    floor_person_count = 0

    l_queue = deque()
    f_queue = deque()

    
    cur_leader = " "
    cur_follower = " "

    pair_mutex = Semaphore(1)
    pair_count = 0


    l_mutex = Semaphore(1)
    f_mutex = Semaphore(1)

    l_queue_mutex = Semaphore(1)
    f_queue_mutex = Semaphore(1)

    floor_person_count_mutex = Semaphore(1)
    music_starts = Semaphore(0)
    floor_empty = Semaphore(1)
    music_changing = Semaphore(1)

    pair_leader = Semaphore(0)
    pair_follower = Semaphore(0)


    turnstile = Semaphore(0)
    turnstile2 = Semaphore(1)
    
    
    queue_making()                                              #Just to make sure both are in queue.
    
    for i in range(l_count):
        leaders = Thread(target=leader, args=[i])
        leaders.start()                                        # Leaders thread is starting
    
    for i in range(f_count):
        followers = Thread(target=follower, args=[i])
        followers.start()                                      # Followers thread is starting
    
    sleep(1)                                                   #Sleep for synchronization
    
    band_leaders = Thread(target=band_leader)
    band_leaders.start()                                       #Band Leader thread is starting

