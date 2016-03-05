from sys import argv

script, input1, input2 = argv
from threading import Semaphore, Lock, Thread
from time import sleep
from random import random
import argparse
from timeit import Timer

(THINKING, EATING) = (0, 1)                               #philosopher states

def left_fork(id):
    return id

def right_fork(id):
    return (id+1) % No_Phil

def right(id):
    return (id+1) % No_Phil

def left(id):
    return (id+No_Phil-1) % No_Phil

def get_fork(id):

    global mutex
    global state
    global sem

    mutex.acquire()
    state[id] = 'hungry'
    test(id)
    mutex.release()
    sem[id].acquire()

def put_fork(id):

    global mutex
    global state
    global sem

    mutex.acquire()
    state[id] = 'thinking'
    test(right(id))
    test(left(id))
    mutex.release()

def test(id):

    global state
    if state[id] == 'hungry' and state[left(id)] != 'eating' and state[right(id)] != 'eating':   
        state[id] = 'eating'
        sem[id].release()

def Sol_footman(id,meal):

    global forks
    global footman
    state = THINKING
    for i in range(meal):
        sleep(random())
        if(state == THINKING):
            
            footman.acquire()
            forks[right_fork(id)].acquire()
            forks[left_fork(id)].acquire()
            state = EATING
        else:
            
            forks[right_fork(id)].release()
            forks[left_fork(id)].release()
            state = THINKING
            footman.release()
    #print("Finish footman")


def Sol_lefthand(id,meal):

    global forks
    state = THINKING
    for i in range(meal):
        sleep(random())
        if(state == THINKING):
            
            if(id == 5 or id == 9):                          #take these ids as Left handed persons.
                forks[left_fork(id)].acquire()
                forks[right_fork(id)].acquire()
                state = EATING
            else:
                forks[right_fork(id)].acquire()
                forks[left_fork(id)].acquire()
                state = EATING
        else:
            if(id == 5 or id == 9):
                forks[left_fork(id)].release()
                forks[right_fork(id)].release()
                state == THINKING   
            else:
                forks[right_fork(id)].release()
                forks[left_fork(id)].release()
                state == THINKING
    #print("Finish lefthand")


def Sol_Tanenbaum(id,meal):

    for i in range(meal):
        get_fork(id)
        sleep(random())
        put_fork(id)
    #print("Finish Tanenbaum")



def solu1():

    global No_Phil
    global Meal
    
    """for i in range(No_Phil):
        t1 = Thread(target= Sol_footman, args = (i,Meal))"""
    
    phil = [Thread(target = Sol_footman, args = (i, Meal)) for i in range(No_Phil)]
    
    for t in phil:
        t.start()
        
    for t in phil:
        t._Thread__stop()
        #sleep(0.1)
    

def solu2():

    global No_Phil
    global Meal
    ts = []
    
    phil2 = [Thread(target = Sol_lefthand, args = (n,Meal)) for n in range(No_Phil)]
   
    for t in phil2:
        t.start()
           
    for t in phil2:
        t._Thread__stop()
        #sleep(0.1)
        
        
def solu3():

    global No_Phil
    global Meal
    
    phil3 = [Thread(target = Sol_Tanenbaum, args = (i, Meal)) for i in range(No_Phil)]

    for t in phil3:
        t.start()
        
    for t in phil3:
        t._Thread__stop()
        #sleep(0.1)

if __name__ == '__main__':
    
    No_Phil = int(input1)
    Meal = int(input2)
    forks = [Semaphore(1) for i in range(No_Phil)]                    
    sem = [Semaphore(0) for i in range(No_Phil)]                      
    footman = Semaphore(No_Phil-1)                                           
    mutex = Semaphore(1)                                                   
    state = ['thinking'] * No_Phil                                   

    print "Running dining philosophers simulation: %d philosophers, %d meals each. " %(No_Phil,Meal)

    t1 = Timer(solu1)
    print("1. Footman solution, time elapsed: {:0.4f}s".format(t1. timeit(1000)))
    
    #sleep(5)
    
    #t2 = Timer(solu2)
    #print("2. Left-handed solution, time elapsed: {:0.4f}s".format(t2. timeit(1000)))
    
    #sleep(5)
    
    #t3 = Timer(solu3)
    #print("3. Tanenbaum's solution, time elapsed: {:0.4f}s".format(t3. timeit(1000)))
    #sleep(5)
    
