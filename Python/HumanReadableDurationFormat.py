def format_duration(seconds):
    if seconds == 0:
        return 'now'
        
    def join(xs):
        commas,last = ', '.join(xs[:-1]),xs[-1:]
        if len(commas) > 0:
            last =  [commas] + last
        return ' and '.join(last)
    ret = []
    d = {
        'year': 31536000,
        'day': 86400,
        'hour': 3600,
        'minute': 60,
        'second': 1
    }
    for k,v in d.items():
        if seconds >= v:
            seconds,t = seconds%v,(seconds-seconds%v)//v
            ret.append(f'{t} {k}{"s" if t > 1 else ""}')     
    return join(ret)