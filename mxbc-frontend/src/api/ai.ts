import request from '@/utils/request'
export const aigetAnswer = (params) => {
  return request({
    url: '/ai-service',
    method: 'post',
    data: params 
  });
};

