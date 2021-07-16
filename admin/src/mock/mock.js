export default {
    'post|/xboot/login': option => {
        return {
            status: 200,
            message: 'success',
            data: {
                success: true
            }
        };
    }
}