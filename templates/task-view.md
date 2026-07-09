> [!important]+ By Due Date
>
> ```tasks
> group by function                                                            \
>     const date = task.due.moment;                                            \
>     return                                                                   \
>         (!date)                                     ? '%%5%% Undated'      : \
>         !date.isValid()                             ? '%%0%% Invalid date' : \
>         date.isBefore(moment(), 'day')              ? '%%1%% Overdue'      : \
>         date.isSame(moment(), 'day')                ? '%%2%% Today'        : \
>         date.isSame(moment().add(1, 'days'), 'day') ? '%%3%% Tomorrow'     : \
>         '%%4%% Future';
> ```

> [!info]- By Scheduled Date
>
> ```tasks
> group by function                                                            \
>     const date = task.scheduled.moment;                                      \
>     return                                                                   \
>         (!date)                                     ? '%%5%% Undated'      : \
>         !date.isValid()                             ? '%%0%% Invalid date' : \
>         date.isBefore(moment(), 'day')              ? '%%1%% Overdue'      : \
>         date.isSame(moment(), 'day')                ? '%%2%% Today'        : \
>         date.isSame(moment().add(1, 'days'), 'day') ? '%%3%% Tomorrow'     : \
>         '%%4%% Future';
> ```
