#!/usr/bin/python

import numpy as np
from operator import itemgetter

def outlierCleaner(predictions, ages, net_worths):
    """
        Clean away the 10% of points that have the largest
        residual errors (difference between the prediction
        and the actual net worth).

        Return a list of tuples named cleaned_data where 
        each tuple is of the form (age, net_worth, error).
    """
    
    cleaned_data = []

    ### your code goes here
    for pred, y,age in zip(predictions, net_worths, ages):
        err = abs(pred - y)
        cleaned_data.append((age,y, err))
    
    
    
    
    cleaned_data.sort(key=itemgetter(2))
    cleaned_data = cleaned_data[: int(len(cleaned_data)* 0.9)]
    return cleaned_data

