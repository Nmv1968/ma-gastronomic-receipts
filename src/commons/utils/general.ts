import { HttpException, HttpStatus } from '@nestjs/common';
export interface IGenericResponse<T> {
    id?: string;
    success: boolean;
    data?: T;
    message?: string;
    token?: string;
    createdAt?: number;
    errors?: any[];
    error?: object;
    
    meta?: {
      total: number;
      page: number;
      size: number;
      pages?: number;
    };
  }

  export function getReportDate(): String {
    const currentDate = new Date();
    const fullDate = currentDate.toLocaleDateString('en-GB');
    const hours = currentDate.getHours();
    const minutes = currentDate.getMinutes();
    const seconds = currentDate.getSeconds();
    return `${fullDate} ${hours}-${minutes}-${seconds}`;
  }

  export const validateDateTime12Hour = (date, locale, timeZone) => {
    let options:any;
    if (date != null) {
      const dateValid = new Date(date)
      if (!isNaN(dateValid.getTime())) {
        options = {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit',
          second:'2-digit',
          hour12: false, 
          timeZone: timeZone, 
          timeZoneName: 'short' 
        };
        const dateTime = dateValid.toLocaleTimeString(locale, options);
        return dateTime.toUpperCase().replace(/AM|PM/, match => match.toUpperCase());;
      }
    } else {
      return "";
    }
  };