module int_to_leds_m {
  requires {
    interface counter_output input;
    interface leds;
  }
}
implementation
{
  command void input.init()
  {
    call leds.init();
    call leds.red_off();
    call leds.yellow_off();
    call leds.green_off();
  }

  task void output_done()
  {
    signal input.output_complete(1);
  }

  command void input.output(int value)
  {
    if (value & 1) call leds.yellow_on();
    else call leds.yellow_off();
    if (value & 2) call leds.green_on();
    else call leds.green_off();
    if (value & 4) call leds.red_on();
    else call leds.red_off();

    post output_done();
  }
}
