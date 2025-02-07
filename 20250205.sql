
    select
        fil_100_ctnt5,
        sigumgo_age_ac_g
    from acl_sigumgo_mas
    where 1=1
    and mng_no = 1
    and sigumgo_hoikye_yr = 2024
    and sigumgo_age_ac_g in (1,2,3)
    order by sigumgo_age_ac_g, fil_100_ctnt5



-- ---------------------------------------------------------
-- 모계좌
select
    fil_100_ctnt5,
    sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 = '02800001100000024'
and gjdt <= '20240930'
group by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
order by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g

-- ---------------------------------------------------------

select
    sigumgo_acno,
    to_char(sigumgo_trx_g) as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sgghando_slv
where 1=1
and sigumgo_acno = '02800001100000024'
group by sigumgo_acno, sigumgo_trx_g
order by sigumgo_acno, sigumgo_trx_g


-- ---------------------------------------------------------
-- 자계좌(배정)

select
    fil_100_ctnt5,
    sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 = '02800001210000024'
group by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
order by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g

-- ---------------------------------------------------------

select
    sigumgo_acno,
    to_char(sigumgo_trx_g) as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sgghando_slv
where 1=1
and sigumgo_acno = '02800001210000024'
group by sigumgo_acno, sigumgo_trx_g
order by sigumgo_acno, sigumgo_trx_g

-- ---------------------------------------------------------
-- 자계좌(배정 손계좌가 일상)

select
    fil_100_ctnt5,
    sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 = '02811001210000024'
group by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
order by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g

-- ---------------------------------------------------------

select
    sigumgo_acno,
    to_char(sigumgo_trx_g) as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sgghando_slv
where 1=1
and sigumgo_acno = '02811001210000024'
group by sigumgo_acno, sigumgo_trx_g
order by sigumgo_acno, sigumgo_trx_g

-- ---------------------------------------------------------
-- 손계좌(배정)

select
    fil_100_ctnt5,
    sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 = ''
group by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
order by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g

-- ---------------------------------------------------------

select
    sigumgo_acno,
    to_char(sigumgo_trx_g) as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sgghando_slv
where 1=1
and sigumgo_acno = ''
group by sigumgo_acno, sigumgo_trx_g
order by sigumgo_acno, sigumgo_trx_g

-- ---------------------------------------------------------
-- 손계좌(일상)

select
    fil_100_ctnt5,
    sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 = '02811001250004724'
group by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
order by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g

-- ---------------------------------------------------------

select
    sigumgo_acno,
    to_char(sigumgo_trx_g) as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sgghando_slv
where 1=1
and sigumgo_acno = '02811001250004724'
group by sigumgo_acno, sigumgo_trx_g
order by sigumgo_acno, sigumgo_trx_g

-- ---------------------------------------------------------
-- 자계좌(일상)

select
    fil_100_ctnt5,
    sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 = '02800001250002524'
group by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
order by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g

-- ---------------------------------------------------------

select
    sigumgo_acno,
    to_char(sigumgo_trx_g) as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sgghando_slv
where 1=1
and sigumgo_acno = '02800001250002524'
group by sigumgo_acno, sigumgo_trx_g
order by sigumgo_acno, sigumgo_trx_g

-- ---------------------------------------------------------


select
    sigumgo_acno,
     opp_sigumgo_mng_no,
    to_char(sigumgo_trx_g) as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sgghando_slv
where 1=1
and sigumgo_acno = '02800001100000024'
and opp_sigumgo_mng_no not in (
            select
        fil_100_ctnt5
    from acl_sigumgo_mas
    where 1=1
    and mng_no = 1
    and sigumgo_hoikye_yr = 2024
    and ich_sigumgo_gun_gu_c = 0
    and sigumgo_age_ac_g = 2
    )
group by sigumgo_acno, opp_sigumgo_mng_no, sigumgo_trx_g
order by sigumgo_acno, opp_sigumgo_mng_no, sigumgo_trx_g

-- 모계좌의 93 이 자계좌들의 94의 합과 일치 또는 모계좌의 94가 자계좌들의 93의 합과 일치하는지 확인

select
    sigumgo_acno,
    to_char(sigumgo_trx_g) as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sgghando_slv
where 1=1
and sigumgo_acno in (
        select
        fil_100_ctnt5
    from acl_sigumgo_mas
    where 1=1
    and mng_no = 1
    and sigumgo_hoikye_yr = 2024
    and ich_sigumgo_gun_gu_c = 0
    and sigumgo_age_ac_g = 1
    )
group by sigumgo_acno, sigumgo_trx_g
order by sigumgo_acno, sigumgo_trx_g

-- ---------------------------------------------------------

select
    sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 in (
        select
        fil_100_ctnt5
    from acl_sigumgo_mas
    where 1=1
    and mng_no = 1
    and sigumgo_hoikye_yr = 2024
    and ich_sigumgo_gun_gu_c = 0
    and sigumgo_age_ac_g = 2
    )
group by sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
order by sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g

--

select
    to_char(sigumgo_trx_g) as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sgghando_slv
where 1=1
and sigumgo_acno in (
        select
        fil_100_ctnt5
    from acl_sigumgo_mas
    where 1=1
    and mng_no = 1
    and sigumgo_hoikye_yr = 2024
    and ich_sigumgo_gun_gu_c IN (0, 50)
    and sigumgo_age_ac_g = 2
    )
group by sigumgo_trx_g
order by sigumgo_trx_g

-- ---------------------------------------------------------

select
    to_char(sigumgo_trx_g) as trx_g,
    sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
from acl_sgghando_slv
where 1=1
and sigumgo_acno in (
        select
        fil_100_ctnt5
    from acl_sigumgo_mas
    where 1=1
    and mng_no = 1
    and sigumgo_hoikye_yr = 2024
    and ich_sigumgo_gun_gu_c = 110
    and sigumgo_age_ac_g = 3
    )
group by sigumgo_trx_g
order by sigumgo_trx_g

------------------------------------------------------------------------
-- 손계좌의 금액이 배정한 금액과 어떤 관계가 있는지 확인이 필요
-- 손계좌가 있는 모계좌 02811001100000024
-- 손계좌가 있는 자계좌 02811001210000024
-- 손계좌 02811001250004724
-- 손계좌는 모두 일상경비 계좌인데 손계좌를 가지고 있는 자계좌들은 모두 배정계좌인가?


    select
        sigumgo_acno,
        opp_sigumgo_mng_no
    from acl_sgghando_slv
    where 1=1
      and sigumgo_acno in (
        select
            fil_100_ctnt5
        from acl_sigumgo_mas
        where 1=1
          and mng_no = 1
          and sigumgo_hoikye_yr = 2024
          and sigumgo_age_ac_g = 3
    )
    group by sigumgo_acno, opp_sigumgo_mng_no
    order by sigumgo_acno, opp_sigumgo_mng_no



    select
        sigumgo_acno,
        opp_sigumgo_mng_no,
        to_char(sigumgo_trx_g) as trx_g,
        sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
    from acl_sgghando_slv
    where 1=1
      and sigumgo_acno = '02811001250004724'
    group by sigumgo_acno, opp_sigumgo_mng_no, sigumgo_trx_g
    order by sigumgo_acno, opp_sigumgo_mng_no, sigumgo_trx_g

    -- -------------------------------------------------------
    -- 손계좌가 있는 경우 거래구분 분석

    -- ---------------------------------------------------------


    select
        sigumgo_acno,
        to_char(sigumgo_trx_g) as trx_g,
        sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
    from acl_sgghando_slv
    where 1=1
      and sigumgo_acno = '02811001100000024'
    group by sigumgo_acno, sigumgo_trx_g
    order by sigumgo_acno, sigumgo_trx_g


    select
        to_char(sigumgo_trx_g) as trx_g,
        sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
    from acl_sgghando_slv
    where 1=1
      and sigumgo_acno in (
        select
            fil_100_ctnt5
        from acl_sigumgo_mas
        where 1=1
          and mng_no = 1
          and sigumgo_hoikye_yr = 2024
          and ich_sigumgo_gun_gu_c = 110
          and sigumgo_age_ac_g = 2
    )
    group by sigumgo_trx_g
    order by sigumgo_trx_g

    select
        to_char(sigumgo_trx_g) as trx_g,
        sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
    from acl_sgghando_slv
    where 1=1
      and sigumgo_acno in (
        select
            fil_100_ctnt5
        from acl_sigumgo_mas
        where 1=1
          and mng_no = 1
          and sigumgo_hoikye_yr = 2024
          and ich_sigumgo_gun_gu_c = 110
          and sigumgo_age_ac_g = 3
    )
    group by sigumgo_trx_g
    order by sigumgo_trx_g


    -- 손계좌의 지출은 67-93 반납은 17-93인데 모계좌에서도 같은 거래구분으로 표시되는지 확인 필요

    select
        fil_100_ctnt5,
        sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
        sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
    from acl_sigumgo_slv
    where 1=1
      and fil_100_ctnt5 = '02811001100000024'
    group by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
    order by fil_100_ctnt5, sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g


    select
        sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
        sum(decode(crt_can_g, 1, -1, 2, -1, 33, -1, 1) * tramt) as tramt
    from acl_sigumgo_slv
    where 1=1
      and fil_100_ctnt5 in (
        select
            fil_100_ctnt5
        from acl_sigumgo_mas
        where 1=1
          and mng_no = 1
          and sigumgo_hoikye_yr = 2024
          and ich_sigumgo_gun_gu_c = 110
          and sigumgo_age_ac_g = 3
    )
    group by  sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
    order by  sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
