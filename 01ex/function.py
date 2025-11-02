import math as m

def gauss(x, mu, sigma):
    y = x - mu
    return 1 / m.sqrt(2 * m.pi * sigma**2) * m.exp(-0.5 * (y**2) / sigma**2)
