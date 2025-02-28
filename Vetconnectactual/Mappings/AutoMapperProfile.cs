using System;
using AutoMapper;
using VetConnect_v1.Models;
using VetConnect_v1.DTOs;


namespace VetConnect_v1.Mappings
{
    public class AutoMapperProfile : Profile
    {
        public AutoMapperProfile()
        {
            CreateMap<Cita, CitaDto>().ReverseMap()
            .ForMember(dest => dest.FechaHora, opt => opt.MapFrom(src => src.FechaHora));
            CreateMap<Usuario, UsuarioDto>().ReverseMap();
            CreateMap<Mascota, MascotaDto>().ReverseMap();
            // Mapeo para la búsqueda de veterinarios (DTO simple)
            CreateMap<Veterinario, VeterinarioDto>().ReverseMap();
           // Agrega más mapeos aquí si tienes otros DTOs
        }
    }
}
