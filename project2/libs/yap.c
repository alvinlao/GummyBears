void yap_send(unsigned char val) {
	unsigned char j;
	//Send the start bit
	txon=0;
	wait_bit_time();
	for(j=0;j<8;++j) {
		txon=val&(0x01<<j)?1:0;
		wait_bit_time();
	}
	txon=1;
	//Send the stop bits
	wait_bit_time();
	wait_bit_time();
}


void yap_receive(int min) {
	unsigned char j, val;
	int v;

	//Skip the start bit
	val=0;
	wait_one_and_half_bit_time();
	for(j=0;j<8;++j) {
		v=getADC(0);
		val|=(v>min)?(0x01<<j):0x00;
		wait_bit_time();
	}
	//Wait for stop bits
	wait_one_and_half_bit_time();
}
