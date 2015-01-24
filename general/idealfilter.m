function filtered_data=idealfilter(data,low_frq,high_frq,sampling)
%Filter to low_frq:high_frq
        spectrum=fft(data);

        %Set to zero everything except low_frw - high_frq band 
        frq_step=sampling/(length(spectrum)/2);
        lower_bound=int32(low_frq/frq_step);
        if lower_bound==0; lower_bound=1; end
        spectrum(1:lower_bound)=0;
        spectrum(length(spectrum)-lower_bound:length(spectrum))=0;
        upper_bound=int32(high_frq/frq_step);
        spectrum(upper_bound:length(spectrum)-upper_bound)=0;

        filtered_data=real(ifft(spectrum));