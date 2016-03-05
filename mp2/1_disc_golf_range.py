from time import sleep
from random import random
import sys
from threading import Thread, Lock, Semaphore
import threading

Frolfer = raw_input("Enter number of Frolfer ")
Stash = raw_input("Enter Initial Stash Size ")
Disk = raw_input("Enter Disk per Bucket ")

frolfer = int(Frolfer)
stash = int(Stash)
disk = int(Disk)

discs_on_field = 0
mutex = Lock()

def frolferr(i, mutex):
    
    global stash
    global discs_on_field
    
    print 'Frolfer: %d calling for bucket \n' %i
    
    if stash >= disk:
        mutex.acquire()
        stash -= disk                                              #Decrements the size of Stash. 
        mutex.release()
        print "Frolfer %d got %s discs; Stash = %s \n" %(i, disk, stash)
    
          
    for j in range(0,disk):
        print
        print 'Frolfer %d threw disc %s \n' % (i,j)
        discs_on_field += 1 
        sleep(random())
        
    
def cart():
    
    global stash
    global discs_on_field
    
    
    if stash < disk:
        print '#'*100
        print 'Stash = %s; Cart entering field ' % stash
        mutex.acquire()
        stash += discs_on_field                                     #Gathering the discs from the Field. 
        
        print 'Cart done, gathered %s discs; Stash = %s \n' %(discs_on_field,stash)  
        discs_on_field = 0
        print '#'*100
        mutex.release()
    
    
    
while True:
    
    for i in range(0,frolfer):
        
        t = Thread(target=frolferr, args=(i,mutex))               #calling Frolfer thread
        t.start()
        sleep(random())
        t = Thread(target=cart)                                   #calling Cart thread
        t.start()

